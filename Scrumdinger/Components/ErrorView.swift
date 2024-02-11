//
//  ErrorView.swift
//  Scrumdinger
//
//  Created by hybrayhem.
//

import SwiftUI

struct ErrorView: View {
    let errorWrapper: ErrorWrapper
    @Environment(\.dismiss) private var dismiss // read dismiss value of View
    
    var body: some View {
        AdaptiveNavigationStack {
            VStack {
                Text("An error has occured!")
                    .font(.title)
                    .padding(.bottom)
                Text(errorWrapper.error.localizedDescription)
                    .font(.headline)
                Text(errorWrapper.guidance)
                    .font(.caption)
                    .padding(.top)
                Spacer()
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(16)
//            .padding() // Additional outer padding
            .toolbar {
                Button("Dismiss") {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    enum SampleError: Error {
        case errorRequired
    }
    
    let wrapper: ErrorWrapper = ErrorWrapper(
        error: SampleError.errorRequired,
        guidance: "You can safely ignore this error."
    )
    
    return ErrorView(errorWrapper: wrapper)
//    return VStack{}.sheet(isPresented: .constant(true)) {
//        ErrorView(errorWrapper: wrapper)
//    }
}
