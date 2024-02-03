function output = time_frequency_varying_method(method,taps_length,number_of_nft_points,number_of_samping,samping_time_interval,frequency_doppler_shift,number_of_filter_coffecient,number_of_sample_frequency_method,Kc)
channel_coff=[];
zero_padding=@(x) [x zeros(1,number_of_nft_points-length(x))];
switch method
case 1
    for num=1:taps_length
    channel_coff=[channel_coff,Rician_kc(filter_method(number_of_samping,samping_time_interval,frequency_doppler_shift,number_of_filter_coffecient)',Kc)];
    end
case 2
    for num=1:taps_length
    channel_coff=[channel_coff,Rician_kc(spectrum_method(number_of_sample_frequency_method,samping_time_interval,frequency_doppler_shift),Kc)];
    end
end
channel_dft=[];
for num=1:length(channel_coff)
channel_zero_padding=zero_padding(channel_coff(num,:));
channel_dft=[channel_dft;fft(channel_zero_padding,number_of_nft_points)];
end
output=channel_dft';
end