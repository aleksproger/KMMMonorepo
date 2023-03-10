package Multiplatform.Architecture

interface EffectHandler<State, out Action, Effect> {
    suspend fun handle(effect: Effect, store: Store<State, Action, Effect>)
}