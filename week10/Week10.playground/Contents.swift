import Foundation

struct CatFact: Decodable {
    let fact: String
    let length: Int
}

struct CatFactSequence: AsyncSequence {
    typealias Element = CatFact

    let numberOfFacts: Int

    func makeAsyncIterator() -> Iterator {
        Iterator(numberOfFacts: numberOfFacts)
    }

    struct Iterator: AsyncIteratorProtocol {
        let numberOfFacts: Int
        private var currentCount = 0

        init(numberOfFacts: Int) {
            self.numberOfFacts = numberOfFacts
        }

        mutating func next() async -> CatFact? {
            guard currentCount < numberOfFacts else {
                return nil
            }
            
            currentCount += 1

            let url = URL(string: "https://catfact.ninja/fact")!
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let catFact = try JSONDecoder().decode(CatFact.self, from: data)
                return catFact
            } catch {
                print("Error fetching cat fact: \(error)")
                return nil
            }
        }
    }
}

func fetchCatFacts(numberOfFacts: Int) async {
    for await catFact in CatFactSequence(numberOfFacts: numberOfFacts) {
        print(catFact.fact)
    }
}

Task {
    await fetchCatFacts(numberOfFacts: 5)
}
