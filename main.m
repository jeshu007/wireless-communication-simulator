clc; clear; close all;

%% PARAMETERS
N = 1e5; % Number of bits
data = randi([0 1], 1, N);

%% ---------------- BPSK ----------------
tx_bpsk = 2*data - 1;

%% ---------------- QPSK (FIXED) ----------------
% Ensure even number of bits
data_qpsk = data(1:floor(N/2)*2);
data_qpsk = reshape(data_qpsk, 2, []);

% Direct mapping (correct)
I = 2*data_qpsk(1,:) - 1;   % In-phase
Q = 2*data_qpsk(2,:) - 1;   % Quadrature

tx_qpsk = (I + 1j*Q) / sqrt(2);

%% SNR RANGE
snr_db = 0:2:20;

for i = 1:length(snr_db)
    
    snr = 10^(snr_db(i)/10);
    
    %% ---------- BPSK ----------
    signal_power = mean(abs(tx_bpsk).^2);
    noise_power = signal_power / snr;
    
    noise = sqrt(noise_power/2) * randn(1, N);
    rx_bpsk = tx_bpsk + noise;
    
    data_rx_bpsk = rx_bpsk > 0;
    ber_bpsk(i) = sum(data ~= data_rx_bpsk) / N;
    
    %% ---------- QPSK ----------
    signal_power_q = mean(abs(tx_qpsk).^2);
    noise_power_q = signal_power_q / snr;
    
    noise_q = sqrt(noise_power_q/2) * ...
        (randn(1, length(tx_qpsk)) + 1j*randn(1, length(tx_qpsk)));
    
    rx_qpsk = tx_qpsk + noise_q;
    
    % Demodulation (correct)
    rx_real = real(rx_qpsk);
    rx_imag = imag(rx_qpsk);
    
    bit1 = rx_real > 0;
    bit2 = rx_imag > 0;
    
    % Reconstruct bits
    data_rx_qpsk = zeros(1, length(data_qpsk)*2);
    data_rx_qpsk(1:2:end) = bit1;
    data_rx_qpsk(2:2:end) = bit2;
    
    % Correct BER calculation
    original_bits = reshape(data_qpsk, 1, []);
    ber_qpsk(i) = sum(original_bits ~= data_rx_qpsk) / length(original_bits);
    
    % Debug print
    fprintf("SNR=%d dB | BPSK BER=%f | QPSK BER=%f\n", ...
        snr_db(i), ber_bpsk(i), ber_qpsk(i));
end

%% ---------------- BER PLOT ----------------
figure;
semilogy(snr_db, ber_bpsk, '-o','LineWidth',2); hold on;
semilogy(snr_db, ber_qpsk, '-s','LineWidth',2);

grid on;
xlabel('SNR (dB)');
ylabel('BER');
legend('BPSK','QPSK');
title('BPSK vs QPSK Performance');

%% ---------------- CONSTELLATION ----------------

% Clean QPSK constellation
figure;
plot(real(tx_qpsk), imag(tx_qpsk), 'bo');
grid on;
xlabel('In-Phase');
ylabel('Quadrature');
title('QPSK Constellation (Transmitted)');
axis equal;

% Noisy constellation
snr_test = 10;
snr_lin = 10^(snr_test/10);

signal_power = mean(abs(tx_qpsk).^2);
noise_power = signal_power / snr_lin;

noise = sqrt(noise_power/2) * ...
    (randn(1,length(tx_qpsk)) + 1j*randn(1,length(tx_qpsk)));

rx_test = tx_qpsk + noise;

figure;
plot(real(rx_test), imag(rx_test), 'r.');
grid on;
xlabel('In-Phase');
ylabel('Quadrature');
title(['QPSK Constellation with Noise (SNR = ', num2str(snr_test), ' dB)']);
axis equal;

% Combined view
figure;
plot(real(tx_qpsk), imag(tx_qpsk), 'bo'); hold on;
plot(real(rx_test), imag(rx_test), 'r.');
legend('Transmitted','Received');
title('QPSK Constellation Comparison');
grid on;
axis equal;