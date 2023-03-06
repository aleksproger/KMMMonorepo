package Multiplatform.Architecture

interface EffectHandler<State, out Action, in Effect> {
    suspend fun handle(effect: Effect, store: Store<State, Action>)
}