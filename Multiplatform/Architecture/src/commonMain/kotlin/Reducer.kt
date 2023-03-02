package Multiplatform.Architecture

interface Reducer<State, in Action, out Effect> {
    fun reduce(state: State, action: Action): Pair<State, Effect>
}