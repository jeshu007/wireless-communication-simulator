📡 Wireless Communication Performance Analysis (BPSK vs QPSK)

📌 Overview
This project analyzes and compares the performance of BPSK (Binary Phase Shift Keying) and QPSK (Quadrature Phase Shift Keying) modulation techniques over an AWGN (Additive White Gaussian Noise) channel.

The system evaluates:
* Bit Error Rate (BER)
* Signal-to-Noise Ratio (SNR)
* Constellation diagrams (clean & noisy)

🎯 Objectives
* Simulate digital modulation schemes (BPSK & QPSK)
* Compare BER vs SNR performance
* Visualize signal constellation before and after noise
* Understand noise impact on wireless communication systems

🛠️ Tools & Technologies
* MATLAB
* Digital Communication Concepts
* AWGN Channel Model

📊 Results
🔹 BER vs SNR Plot
Shows performance comparison between BPSK and QPSK.
* BPSK performs better at lower SNR
* QPSK provides higher data rate but needs better SNR

🔹 Constellation Diagrams
* Clean QPSK constellation (ideal points)
* Noisy QPSK constellation (with AWGN)
* Transmitted vs Received comparison

📂 Project Structure

```
├── main.m                        # MATLAB simulation code
├── ber_plot.png                  # BER vs SNR graph
├── constellation_clean.png       # Ideal QPSK constellation
├── constellation_noisy.png       # Noisy constellation
├── constellation_comparison.png  # Tx vs Rx comparison
└── README.md                     # Project documentation
```
---
⚙️ How to Run
1. Open MATLAB
2. Navigate to the project folder
3. Run:

```matlab
main
```

📈 Key Observations
* BER decreases as SNR increases
* BPSK is more robust in noisy environments
* QPSK is bandwidth-efficient (2 bits per symbol)
* Noise spreads constellation points, causing errors

🚀 Future Improvements
* Add Rayleigh fading channel
* Include higher-order modulation (16-QAM, 64-QAM)
* Implement real-time signal visualization
* Extend to OFDM systems

👨‍💻Author
Jeswant P
Electronics and Communication Engineering (ECE)
