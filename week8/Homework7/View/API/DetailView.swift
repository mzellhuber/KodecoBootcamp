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

struct DetailView: View {
  let entry: Entry
  
  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 15) {
        Text(entry.api)
          .font(.largeTitle)
          .bold()
          .padding(.vertical, 10)
        
        Divider()
        
        Text("Description")
          .font(.title2)
          .bold()
          .padding(.bottom, 2)
        
        Text(entry.description)
          .padding(.bottom, 10)
        
        Divider()
        
        Group {
          infoRow(title: "Auth Type", value: entry.auth.rawValue, systemImage: "key")
          infoRow(title: "HTTPS Support", value: entry.https ? "Yes" : "No", systemImage: entry.https ? "lock.fill" : "lock.open.fill", valueColor: entry.https ? .green : .red)
          infoRow(title: "CORS", value: entry.cors.rawValue, systemImage: "network")
          Link(destination: URL(string: entry.link) ?? URL(string: "https://example.com")!) {
            HStack {
              Image(systemName: "link")
              Text("Visit API")
            }
            .font(.headline)
            .foregroundColor(.blue)
          }
          Text("Category: \(entry.category)")
            .font(.headline)
        }
        .padding(10)
        .background(Color.secondary.opacity(0.1))
        .cornerRadius(8)
      }
      .padding()
    }
    .navigationBarTitle(Text(entry.api), displayMode: .inline)
  }
  
  private func infoRow(title: String, value: String, systemImage: String, valueColor: Color = .primary) -> some View {
    HStack {
      Label(title, systemImage: systemImage)
      Spacer()
      Text(value)
        .foregroundColor(valueColor)
    }
  }
}

struct DetailView_Preview: PreviewProvider {
  static var previews: some View {
    DetailView(entry: Entry(api: "Example API", description: "This is a description", auth: .apiKey, https: true, cors: .yes, link: "https://example.com", category: "Data"))
  }
}
