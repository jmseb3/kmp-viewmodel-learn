package com.wonddak.viewmodeltest

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform