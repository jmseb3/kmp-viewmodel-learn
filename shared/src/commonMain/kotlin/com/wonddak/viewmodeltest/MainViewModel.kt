package com.wonddak.viewmodeltest

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.launch

open class BaseViewModel : ViewModel() {

    private var _showSplash = MutableStateFlow(true)

    val showSplash: StateFlow<Boolean>
        get() = _showSplash

    fun hideSplash(withDelay: Long) {
        viewModelScope.launch {
            delay(withDelay)
            _showSplash.value = false
            print("스플래쉬 종료")
        }
    }
}