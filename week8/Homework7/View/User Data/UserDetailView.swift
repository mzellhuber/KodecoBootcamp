/// Copyright (c) 2024 Kodeco Inc.
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI

struct UserDetailView: View {
  let user: Result
  
  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 15) {
        HStack {
          Spacer()
          VStack {
            AsyncImage(url: URL(string: user.picture.large)) { image in
              image.resizable()
            } placeholder: {
              ProgressView()
            }
            .frame(width: 150, height: 150)
            .clipShape(Circle())
            .padding(.bottom, 10)
            
            Text(user.name.fullName)
              .font(.largeTitle)
              .bold()
              .padding(.vertical, 10)
          }
          Spacer()
        }
        
        Divider()
        
        Text("Personal Information")
          .font(.title2)
          .bold()
          .padding(.bottom, 2)
        
        Text("Gender: \(user.gender)")
        Text("Email: \(user.email)")
        Text("Date of Birth: \(formattedDate(user.dob.date)) (Age: \(user.dob.age))")
        Text("Phone: \(user.phone)")
        Text("Cell: \(user.cell)")
        
        Divider()
        
        Group {
          Text("Address")
            .font(.headline)
          Text("\(user.location.street.name) \(user.location.street.number), \(user.location.city), \(user.location.state), \(user.location.country)")
          Text("Postcode: \(String(user.location.postcode))")
        }
        .padding(10)
        .background(Color.secondary.opacity(0.1))
        .cornerRadius(8)
      }
      .padding()
    }
    .navigationBarTitle(Text(user.name.fullName), displayMode: .inline)
  }
  
  private func formattedDate(_ dateString: String) -> String {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    if let date = inputFormatter.date(from: dateString) {
      let outputFormatter = DateFormatter()
      outputFormatter.dateStyle = .medium
      return outputFormatter.string(from: date)
    }
    return "N/A"
  }
}

// For preview
struct UserDetailView_Previews: PreviewProvider {
  static var previews: some View {
    UserDetailView(user: Result(gender: "female", name: Name(title: "Ms", first: "Jane", last: "Doe"), location: Location(street: Street(number: 123, name: "Main Street"), city: "Anytown", state: "State", country: "Country", postcode: 12345, coordinates: Coordinates(latitude: "0", longitude: "0"), timezone: Timezone(offset: "+0:00", description: "UTC")), email: "jane.doe@example.com", login: Login(uuid: "uuid", username: "janedoe", password: "password", salt: "salt", md5: "md5", sha1: "sha1", sha256: "sha256"), dob: Dob(date: "1990-01-01T00:00:00.000Z", age: 31), registered: Dob(date: "2010-01-01T00:00:00.000Z", age: 11), phone: "555-1234", cell: "555-5678", id: ID(name: "ID", value: "12345"), picture: Picture(large: "https://randomuser.me/api/portraits/women/81.jpg", medium: "https://randomuser.me/api/portraits/med/women/81.jpg", thumbnail: "https://randomuser.me/api/portraits/thumb/women/81.jpg"), nat: "CH"))
  }
}
