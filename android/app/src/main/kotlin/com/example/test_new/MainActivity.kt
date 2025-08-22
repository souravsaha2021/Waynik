package com.example.test_new

import android.app.Activity
import android.content.Intent
import android.net.Uri
import android.util.Log
import androidx.core.content.FileProvider
import com.example.test_new.arcore.activities.ArActivity
import com.google.ar.core.ArCoreApk
import com.example.test_new.mlkit.activities.CameraSearchActivity
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import org.apache.commons.io.FilenameUtils
import payment.sdk.android.cardpayment.CardPaymentData
import payment.sdk.android.cardpayment.CardPaymentRequest
import payment.sdk.android.payments.PaymentsLauncher
import payment.sdk.android.payments.PaymentsRequest
import java.io.File

class MainActivity : FlutterFragmentActivity() {
    private val CARD_PAYMENT_REQUEST_CODE = 1001
    private val paymentClient = PaymentsLauncher(
        this,
    ) { result ->

        Log.d("TAG", ": $result")
        methodChannelResult?.success(when (result.toString()) {
            "Success","success" -> "success"
            "failed","failure","Failed", "Failure" -> "Failed"
            else -> result.toString()
        })
//        methodChannelResult.success(result)
//        onPaymentResult(result)
    }
    private val CHANNEL = "com.webkul.magento_mobikul/channel"
    var methodChannelResult: MethodChannel.Result? = null

    @Override
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            try {
                methodChannelResult = result;
                if (call.method.equals("fileviewer")) {
                    var path: String = call.arguments()!!
                    var file = File(path)
                    val extension = FilenameUtils.getExtension(path)

                    val photoURI: Uri = FileProvider.getUriForFile(
                        this.applicationContext,
                        this.applicationContext.packageName.toString(),
                        file
                    )
                    val intent = Intent(Intent.ACTION_VIEW)
                    intent.setFlags(Intent.FLAG_ACTIVITY_NO_HISTORY)
                    intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
                    intent.setDataAndType(photoURI, "application/" + extension)
                    if (intent.resolveActivity(getPackageManager()) != null) {
                        //if device have requested extension app then respective app will open
                        println("File extension app found in the device")
                        startActivity(intent);
                    } else {
                        //if device don't have requested extension app then all app option will be visible.
                        println("File extension app Not found in the device")

                        intent.setDataAndType(photoURI, "*/*")
                        startActivity(intent);
                    }
                    result.success(true)

                } else if (call.method == "initialLink") {
                    val initialUrl = initialLink()
                    if (initialUrl != null) {
                        result.success(initialLink())
                    } else {
                        result.error("UNAVAILABLE", "No deep link found", null)
                    }
                } else if (call.method == "imageSearch") {
                    startImageFinding()
                } else if (call.method == "textSearch") {
                    startTextFinding()
                } else if (call.method == "showAr") {
                    if (call.hasArgument("url")) {
                        Log.d("TEST_LOG", call.argument("url") ?: "No Name")
                    }
                    showArActivity(call.argument("name"), call.argument("url"))

                } else if (call.method == "ngeniusonline") {
                    println("negenious  paymentFile extension app found in the device")


                    var cardPaymentRequest: CardPaymentRequest? = null

                    val arguments = call.arguments as? Map<String, Any>
                    if (arguments == null) {
                        result.error(
                            "INVALID_ARGUMENTS",
                            "Expected arguments of type [String: Any]",
                            null
                        )
                        return@setMethodCallHandler
                    }

                    Log.d("ngeniusonline", "configureFlutterEngine:ngeniusonline   $arguments")

                    val paymentSheetData = arguments.get("paymentSheetData") as? Map<String, Any>
                    val links = paymentSheetData?.get("_links") as? Map<String, Any>
                    val code2 = (links?.get("payment") as? Map<String, Any>)?.get("href") as String
                    val auth_Url2 =
                        (links?.get("payment-authorization") as? Map<String, Any>)?.get("href") as String

//                    val code = (links?.get("payment")as String)
//                        .takeIf { it.isNotBlank() }
//                        ?.split("=")
//                        ?.getOrNull(1)
//                        .orEmpty()
//
//                    val auth_Url = (links.get("payment-authorization")as String)
//                        .takeIf { it.isNotBlank() }
//                        ?.split("=")
//                        ?.getOrNull(1)
//                        .orEmpty()

                    Log.d(
                        "ngeniusonline_Pays",
                        " Code -> " + code2 + " payment-authorization  --> " + (links.get("payment-authorization")) + " auth_Url--> " + auth_Url2
                    )

                    cardPaymentRequest = CardPaymentRequest.builder()
                        .gatewayUrl(auth_Url2)
                        .code(code2)
                        .build()
                    val paymentRequest = PaymentsRequest.builder()
                        .gatewayAuthorizationUrl(auth_Url2)
                        .payPageUrl(code2)
                        .setLanguageCode("en")
                        .build()
                    paymentRequest?.let {
                        paymentClient?.launch(
                            it
                        )
                    }

                }

            } catch (e: Exception) {
                print(e)
            }
        }
    }


    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == CARD_PAYMENT_REQUEST_CODE) {
            Log.d("payment", "onActivityResult: data" + data)
            when (resultCode) {
                Activity.RESULT_OK -> onCardPaymentResponse(
                    CardPaymentData.getFromIntent(data!!)

                )

                Activity.RESULT_CANCELED ->
                    methodChannelResult?.error("401", "Cancelled.", "")

                else -> methodChannelResult?.error("400", "Failed", "")
            }
        }

        if (requestCode == 101 && resultCode == Activity.RESULT_OK) {
            methodChannelResult?.success(data?.getStringExtra(CameraSearchActivity.CAMERA_SEARCH_HELPER))
        }
    }

//        fun onPaymentResult(result: PaymentsResult) {
//        when (result) {
//            PaymentsResult.Cancelled ->
//
////        methodChannelResult.success(result)
//                _uiState.update {
//                it.copy(state = MainViewModelStateType.PAYMENT_CANCELLED)
//            }
//
//            is PaymentsResult.Failed -> _uiState.update {
//                it.copy(state = MainViewModelStateType.PAYMENT_FAILED, message = result.error)
//            }
//
//            PaymentsResult.PartialAuthDeclineFailed -> _uiState.update {
//                it.copy(state = MainViewModelStateType.PAYMENT_PARTIAL_AUTH_DECLINE_FAILED)
//            }
//
//            PaymentsResult.PartialAuthDeclined -> _uiState.update {
//                it.copy(state = MainViewModelStateType.PAYMENT_PARTIAL_AUTH_DECLINED)
//            }
//
//            PaymentsResult.PartiallyAuthorised -> _uiState.update {
//                it.copy(state = MainViewModelStateType.PAYMENT_PARTIALLY_AUTHORISED)
//            }
//
//            PaymentsResult.PostAuthReview -> _uiState.update {
//                it.copy(state = MainViewModelStateType.PAYMENT_POST_AUTH_REVIEW)
//            }
//
//            PaymentsResult.Success -> {
//        methodChannelResult.success(result)
//            }
//
//            PaymentsResult.Authorised -> _uiState.update {
//                it.copy(state = MainViewModelStateType.AUTHORIZED)
//            }
//        }
//    }
    fun onCardPaymentResponse(data: CardPaymentData) {
        when (data.code) {
            CardPaymentData.STATUS_PAYMENT_AUTHORIZED,
            CardPaymentData.STATUS_PAYMENT_CAPTURED -> {
//                view.showOrderSuccessful()

                methodChannelResult?.success(data)
            }

            CardPaymentData.STATUS_PAYMENT_FAILED -> {
//                view.showError("Payment failed")
                methodChannelResult?.error("401", "Failed", "")
            }

            CardPaymentData.STATUS_GENERIC_ERROR -> {
//                view.showError("Generic error(${data.reason})")
                methodChannelResult?.error("401", "Generic error(${data.reason})", "")
            }

            else -> {
//                IllegalArgumentException(
//                    "Unknown payment response (${data.reason})"
//                )
                methodChannelResult?.error("401", "Unknown payment response (${data.reason})", "")
            }

        }
    }

    fun initialLink(): String? {
        val uri = intent.data
        Log.d("Deep link url:::", uri.toString())
        return if (uri != null) {
            uri.toString();
        } else {
            null
        }
    }

//    private fun String.toOrderResponse(): OrderResponse? {
//        return try {
//            val jsonData = this.toByteArray()
//            val orderResponse = OrderResponse.fromJson(jsonData)
//            orderResponse
//        } catch (e: Exception) {
//            println("Failed to decode OrderResponse: $e")
//            null
//        }
//    }

    private fun startImageFinding() {
        val intent = Intent(this, CameraSearchActivity::class.java)
        intent.putExtra(
            CameraSearchActivity.CAMERA_SELECTED_MODEL,
            CameraSearchActivity.IMAGE_LABELING
        )
        startActivityForResult(intent, 101)
    }

    private fun startTextFinding() {
        val intent = Intent(this, CameraSearchActivity::class.java)
        intent.putExtra(
            CameraSearchActivity.CAMERA_SELECTED_MODEL,
            CameraSearchActivity.TEXT_RECOGNITION
        )
        startActivityForResult(intent, 101)
    }


    private fun showArActivity(name: String?, url: String?) {
        val availability = ArCoreApk.getInstance().checkAvailability(this)
        if (availability.isSupported) {
            Log.d("TEST_LOG", "${name}----${url}")
            if (name != null && url != null) {
                val intent = Intent(this, ArActivity::class.java)
                intent.putExtra("name", name)
                intent.putExtra("link", url)
                startActivity(intent)
                // methodChannelResult?.success("Supported ");
            } else {
                methodChannelResult?.error("401", "Invalid parameters", "");
            }
        } else {
            methodChannelResult?.error("401", "Your device does not support AR feature", "");
        }
    }
}
