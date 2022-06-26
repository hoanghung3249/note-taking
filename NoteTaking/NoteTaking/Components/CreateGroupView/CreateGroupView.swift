//
//  CreateGroupView.swift
//  NoteTaking
//
//  Created by Hung Nguyen on 26/06/2022.
//

import SwiftUI

struct CreateGroupView: View {
    
    @State private var groupName = ""
    @State private var groupNoteType: GroupNoteType = .folder
    @Binding var isShownPopUp: Bool
    
    var body: some View {
        VStack {
            Text(R.string.localizable.commonTextFolderName())
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.indianKhaki)
            
            TextField("", text: $groupName)
                .font(.system(size: 18).bold())
                .placeholder(when: groupName.isEmpty, placeholder: {
                    Text(R.string.localizable.commonTextPlaceholderFolderName())
                        .font(.system(size: 18).bold())
                        .foregroundColor(.santasGray)
                })
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .strokeBorder(Color.newOrleans,
                                      style: StrokeStyle(lineWidth: 2.0)
                                     )
                )
            
            Divider()
                .background(Color.newOrleans)
            
            HStack {
                Text("Icon")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.santasGray)
                Spacer()
                HStack {
                    Button(action: {
                        print("Show icon list")
                    }) {
                        Text(groupNoteType.title)
                            .foregroundColor(.santasGray)
                            .font(.system(size: 18, weight: .regular))
                    }
                    
                    Image(groupNoteType.imageIconName)
                        .resizable()
                        .frame(width: 25, height: 25)
                }
            }
            .padding()
            
            Divider()
                .background(Color.newOrleans)
            
            actionButtonsView
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .strokeBorder(Color.whiteLilac,
                              style: StrokeStyle(lineWidth: 2.0)
                             )
        )
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.whiteLilac)
        )
    }
}

private extension CreateGroupView {
    
    var actionButtonsView: some View {
        
        HStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    isShownPopUp.toggle()
                }) {
                    Text(R.string.localizable.commonCancelButton())
                        .foregroundColor(.santasGray)
                        .font(.system(size: 18, weight: .bold))
                }
                Spacer()
            }
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    print("Create new group")
                }) {
                    Text(R.string.localizable.commonCreateButton())
                        .foregroundColor(.santasGray)
                        .font(.system(size: 18, weight: .bold))
                        .opacity(groupName.isEmpty ? 0.5 : 1)
                }
                .disabled(groupName.isEmpty)
                Spacer()
            }
            Spacer()
        }
        .padding()
    }
    
}

struct CreateGroupView_Previews: PreviewProvider {
    static var previews: some View {
        CreateGroupView(isShownPopUp: .constant(true))
    }
}
