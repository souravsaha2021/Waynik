package payment.sdk.android.cardpayment

import android.content.Intent
import junitparams.JUnitParamsRunner
import org.junit.Assert.assertEquals
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.BeforeEach
import org.junit.runner.RunWith
import org.mockito.Mock
import org.mockito.MockitoAnnotations
import org.mockito.kotlin.whenever
import java.lang.IllegalArgumentException

@RunWith(JUnitParamsRunner::class)
class CardPaymentDataTest {

    @Mock
    lateinit var mockIntent: Intent

    @Mock
    lateinit var fixtCardData: CardPaymentData

    @BeforeEach
    fun setUp() {
        MockitoAnnotations.openMocks(this)
    }

    @org.junit.jupiter.api.Test
    fun getFromIntent() {
        whenever(mockIntent.getParcelableExtra<CardPaymentData>(CardPaymentData.INTENT_DATA_KEY))
                .thenReturn(fixtCardData)

        val actual = CardPaymentData.getFromIntent(mockIntent)

        assertEquals(fixtCardData, actual)
    }

    @org.junit.jupiter.api.Test(expected = IllegalArgumentException::class)
    fun `getFromIntent when intent key not matched`() {
        whenever(mockIntent.getParcelableExtra<CardPaymentData>(CardPaymentData.INTENT_DATA_KEY))
                .thenThrow(IllegalArgumentException())

        CardPaymentData.getFromIntent(mockIntent)
    }
}