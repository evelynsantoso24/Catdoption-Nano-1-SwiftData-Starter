//
//  PetAdoptionView.swift
//  cadoptio
//
//  Created by David Gunawan on 22/03/24.
//

import SwiftUI
import SwiftData

struct PetAdoptionView: View {
    
    @State private var isFilterViewPresented = false
    @State private var isAddNewPetViewPresented = false
    
    
    //swift ada time inference jd gk pake [PetModel] gpp
    @Query var pets: [PetModel]
    @Environment(\.modelContext) var context
    
    
    
//    hapus setelah ada swift data
//    = [
//        PetModel(
//            name: "Leppy",
//            breed: "Domestic",
//            weight: "3 kg",
//            gender:"Female",
//            imageName: "Leppy"
//        ),
//        PetModel(
//            name: "Sky",
//            breed: "Ragdol",
//            weight: "5 kg",
//            gender:"Male",
//            imageName: "Sky"
//        )]
//        
    
    
    
    
    var body: some View {
        NavigationStack {
//            List(pets, rowContent: { pet in
//            })
            
//            List (pets) { pet in
//                PetCardView(pet: pet)
//                
//            }
            
            List {
                ForEach(pets){ pet in
                    PetCardView(pet: pet)
                }
                
                .onDelete(perform: { indexSet in
                    for index in indexSet{
                        let willBeDeletedPet = pets[index]
                        context.delete(willBeDeletedPet)
                    }
                })
          
            }
            .listStyle(.plain)
            .navigationTitle("My Pet")
            .toolbar {
                Button(action: {
                    isAddNewPetViewPresented = true
                }) {
                    Image(systemName: "plus")
                        .foregroundColor(.orange)
                }
                Button(action: {
                    isFilterViewPresented = true
                }) {
                    Image(systemName: "line.3.horizontal.decrease.circle.fill")
                        .foregroundColor(.orange)
                }
            }
            .sheet(isPresented: $isFilterViewPresented) {
                FilterView()
            }
            .sheet(isPresented: $isAddNewPetViewPresented) {
                AddNewPetView()
            }
        }
    }
//    func editPet(){
//        let editPet = pets.first
//        editedPet?.name = "Jaka"
//        
//        try? context.save()
//        
//    }
}

struct PetAdoptionView_Previews: PreviewProvider {
    static var previews: some View {
//        let config = ModelConfiguration(isStoredInMemoryOnly: true)
//        let container = try! ModelContainer(for: PetModel.self, configurations: config)
        
        PetAdoptionView()
    }
}
