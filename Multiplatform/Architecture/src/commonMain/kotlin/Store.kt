package Multiplatform.Architecture

interface Store<State, in Action> {
    fun dispatch(action: Action)
}