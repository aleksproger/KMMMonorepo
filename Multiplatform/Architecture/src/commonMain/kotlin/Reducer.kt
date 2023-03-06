package Multiplatform.Architecture

interface Reducer<State, in Action, out Effect> {
    suspend fun reduce(state: State, action: Action): Pair<State, Effect>
}