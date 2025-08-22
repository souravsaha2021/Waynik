package payment.sdk.android.payments

import androidx.activity.ComponentActivity
import androidx.activity.compose.rememberLauncherForActivityResult
import androidx.activity.result.ActivityResultLauncher
import androidx.compose.runtime.Composable
import androidx.compose.runtime.remember

class PaymentsLauncher(private val activityResultLauncher: ActivityResultLauncher<PaymentsRequest>) {
    constructor(
        activity: ComponentActivity,
        resultCallback: PaymentsResultCallback,
    ) : this(
        activityResultLauncher = activity.registerForActivityResult(
            PaymentsLauncherContract(),
            resultCallback::onResult
        ),
    )

    fun launch(paymentsRequest: PaymentsRequest) {
        activityResultLauncher.launch(paymentsRequest)
    }
}

fun interface PaymentsResultCallback {
    fun onResult(result: PaymentsResult)
}

@Composable
fun rememberPaymentsLauncher(
    resultCallback: PaymentsResultCallback
): PaymentsLauncher {
    val activityResultLauncher = rememberLauncherForActivityResult(
        PaymentsLauncherContract(),
        resultCallback::onResult
    )
    return remember { PaymentsLauncher(activityResultLauncher = activityResultLauncher) }
}