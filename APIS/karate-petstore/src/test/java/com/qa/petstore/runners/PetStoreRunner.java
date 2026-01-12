package com.qa.petstore.runners;

import com.intuit.karate.junit5.Karate;

public class PetStoreRunner {

    @Karate.Test
    Karate runAll() {
        return Karate.run("classpath:com/qa/petstore")
                .relativeTo(getClass());
    }
}
