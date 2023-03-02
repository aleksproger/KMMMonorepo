package Multiplatform.Architecture

interface EffectHandler<State, out Action, in Effect> {
    fun handle(effect: Effect, store: Store<State, Action>)
}