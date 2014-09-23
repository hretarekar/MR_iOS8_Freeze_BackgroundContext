MR_iOS8_Freeze_BackgroundContext
================================

Test MR Freeze on iOS 8 when background context is saved 

To repro the issue:
Step1: Launch app on phone
Step2: Click Launch Modal
Step3: Click Callback & Dismiss
Step4: App Hangs. If not repeat from Step2.

Please check callBack method. Thats where the background context is getting created and saved.
