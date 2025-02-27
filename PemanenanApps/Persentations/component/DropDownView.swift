//
//  DropDownViews.swift
//  PemanenanApps
//
//  Created by Ary Sugiarto on 26/02/25.
//

struct DropDownView: View {
    @Binding var selectedItem: String
    let items: [String]
    @State private var isExpanded: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Button(action: {
                withAnimation { isExpanded.toggle() }
            }) {
                HStack {
                    Text(selectedItem).foregroundColor(.black)
                    Spacer()
                    Image(systemName: "chevron.down").foregroundColor(.black)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
            }
            
            if isExpanded {
                List(items, id: \.self) { item in
                    Button(action: {
                        selectedItem = item
                        withAnimation { isExpanded = false }
                    }) {
                        Text(item)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical, 0)
                            .listRowInsets(EdgeInsets(top: 2, leading: 10, bottom: 2, trailing: 10))
                    }
                }
                .frame(height: 150)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .transition(.opacity)
            }
        }
        .padding(.horizontal, 16)
    }
}

