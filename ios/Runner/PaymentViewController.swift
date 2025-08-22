//
//  PaymentViewController.swift
//  Runner
//
//  Created by suraj on 27/11/24.
//

import UIKit
import NISdk



class PaymentViewController: UIViewController, CardPaymentDelegate {
    var onPaymentCompletion: ((PaymentStatusResult) -> Void)?

    
    var exampleOrderResponse: OrderResponse!
    var paymentSheetData: [String: Any]?
    let paymentDelegate: CardPaymentDelegate? = nil

    func paymentDidComplete(with status: PaymentStatus) {
        print(status)
        if(status == .PaymentSuccess) {
            print("Success Payment==>")
            self.dismiss(animated: true) {
                self.onPaymentCompletion?(.success)

                        print("PaymentViewController dismissed after successful payment.")
                    }
            // Payment was successful
        } else if(status == .PaymentFailed) {
            print("PaymentFailed Payment==>")
            self.dismiss(animated: true) {
                self.onPaymentCompletion?(.failure)

                        print("PaymentViewController dismissed after successful payment.")
                    }

        } else if(status == .PaymentCancelled) {
            print("PaymentCancelled Payment==>")
            self.dismiss(animated: true) {
                self.onPaymentCompletion?(.cancelled)

                        
                    }
        } else {
            print("Invalid Request")
        }
    }
    

    
    func authorizationDidComplete(with status: AuthorizationStatus) {
        switch status {
            case .AuthSuccess:
                print("Authorization succeeded.")
            case .AuthFailed:
                    print("Authorization failed. ")
            default:
                print("Unknown authorization status: \(status)")
            }
        
    }
    
    func showCardPaymentUI(orderResponse: OrderResponse) {
            let sharedSDKInstance = NISdk.sharedInstance
            DispatchQueue.main.async {
                sharedSDKInstance.showCardPaymentViewWith(                
                    cardPaymentDelegate: self,
                    overParent: self,
                    for: orderResponse
                )
                print("Card payment view method called.")
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()        

        parseAndShowPaymentUI()


    }
    
    func parseAndShowPaymentUI() {
            guard
                let paymentSheetData = self.paymentSheetData?["paymentSheetData"] as? [String: Any],
                var paymentData = paymentSheetData as? [String: Any],
                var amount = paymentData["amount"] as? [String: Any]
            else {
                print("Failed to extract or serialize paymentSheetData.")
                return
            }
        if let stringValue = amount["value"] as? String, let doubleValue = Double(stringValue) {
                amount["value"] = doubleValue
            } else if let intValue = amount["value"] as? Int {
                amount["value"] = Double(intValue)
            } else {
                return
            }

            let decoder = JSONDecoder()

            do {
                let orderResponse: OrderResponse = try JSONDecoder().decode(OrderResponse.self, from: ((json(from: paymentData)?.data(using: .utf8))!))
                print("===orderResponse",orderResponse)
                showCardPaymentUI(orderResponse: orderResponse)
            } catch {
                print("Failed to decode OrderResponse: \(error)")
            }
        }
    
    func json(from dictionary: Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: dictionary, options: []) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
    
    func showAuthorizationFailedAlert() {
            let alert = UIAlertController(title: "Authorization Failed",
                                          message: "The payment authorization has failed. Please check your details and try again.",
                                          preferredStyle: .alert)
            
            // Add an action to dismiss the alert and close the view controller
            let dismissAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            }
            
            alert.addAction(dismissAction)
            
            self.present(alert, animated: true, completion: nil)
        }
    
    

    
    
    
}

enum PaymentStatusResult {
    case success
    case failure
    case cancelled
}





