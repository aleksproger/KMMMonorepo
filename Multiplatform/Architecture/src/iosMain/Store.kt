package Multiplatform.Architecture

// import Platform.Foundation
import Platform.SwiftUI.ObservableObject
import Platform.SwiftUI.Published



class ObservableObjectStore<State>(
    private val store: Store<State>
): ObservableObject {
    @Published 
    var state: [Beer] = []
    constructor(initialState: State): this(DefaultStore(initialState, { this.state = it }))
    
}