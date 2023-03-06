package Multiplatform.Architecture

interface Store<State, in Action> {
    suspend fun dispatch(action: Action): State
}