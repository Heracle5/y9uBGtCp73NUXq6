clear all; clc;
% Generate random binary sequence
input_bits = randi([0, 1], 1, 10)

% QPSK Mapping
QPSK_symbols = QPSK_mapper(input_bits)

% Add noise to QPSK symbols (simulating channel effects)
%noisy_QPSK_symbols = awgn(QPSK_symbols, 10); % SNR of 10 dB

% QPSK Demapping
demodulated_bits = QPSK_demapper(QPSK_symbols)'

% Compare input_bits and demodulated_bits for correctness
disp('Original Binary Sequence:');
disp(input_bits);

disp('Demodulated Binary Sequence:');
disp(demodulated_bits);

% Check if the original and demodulated sequences match
if isequal(input_bits, demodulated_bits)
    disp('Demodulation successful! The original and demodulated sequences match.');
else
    disp('Demodulation failed! The original and demodulated sequences do not match.');
end
