function [channel_time_domain,theoretical_psd]=spectrum_method(number_of_sample_frequency_method,samping_time_interval,frequency_doppler_shift)
Hz=1;
frequency_sampling=1/samping_time_interval*Hz;
% frequency_sampling_point=linspace(-frequency_doppler_shift,frequency_doppler_shift,number_of_sample_frequency_method);
% filter_coffecient=sqrt((1./(pi*frequency_doppler_shift))*(1./(sqrt(1-(frequency_sampling_point./frequency_doppler_shift).^2))));
% filter_coffecient([1 end])=sqrt((1./(pi*frequency_doppler_shift))*(1./(sqrt(eps))));
%frequency_sampling_point=linspace(-frequency_sampling/2,frequency_sampling/2,number_of_sample_frequency_method);
frequency_sampling_point=-frequency_sampling/2:frequency_sampling/number_of_sample_frequency_method:(frequency_sampling/2)+(frequency_sampling/number_of_sample_frequency_method);
filter_coffecient=(double(abs(frequency_sampling_point)<=frequency_doppler_shift)).*(sqrt((1./(pi*frequency_doppler_shift))*(1./(sqrt(1-(frequency_sampling_point./frequency_doppler_shift).^2)))));
filter_coffecient(find(filter_coffecient==Inf))=sqrt((1./(pi*frequency_doppler_shift))*(1./(sqrt(eps))));
theoretical_psd=filter_coffecient(1:end-2).^2;
filter_coffecient=[filter_coffecient(1:end-1),filter_coffecient];
filter_coffecient=filter_coffecient(number_of_sample_frequency_method/2+1:3*number_of_sample_frequency_method/2);
%%
%input complex awgn generation
amplitude_of_input_awgn=(number_of_sample_frequency_method/(sqrt((sum(abs(filter_coffecient).^2)))))/sqrt(2); %amplitude of input awgn, to be determined
input_awgn=amplitude_of_input_awgn*(randn(number_of_sample_frequency_method,1)+1i*randn(number_of_sample_frequency_method,1)); %input complex awgn generation
channel_frequency_domian=filter_coffecient'.*input_awgn;
channel_time_domain=ifft(channel_frequency_domian);
end