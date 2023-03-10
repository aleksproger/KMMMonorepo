package Multiplatform.Architecture

interface Store<State, in Action, Effect> {
    suspend fun dispatch(action: Action): State
}