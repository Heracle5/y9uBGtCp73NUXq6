function output_of_filter_discard = filter_method(number_of_samping,samping_time_interval,frequency_doppler_shift,number_of_filter_coffecient)
%%
%filter method

%%
%filter coffecient calculation
%number_of_filter_coffecient =1000 ; %number of filter coffecient, to be determined
samples_index=(-number_of_filter_coffecient:1:number_of_filter_coffecient)*samping_time_interval; %index of samples
samples_of_filter=besselj(1/4,2*pi*frequency_doppler_shift*abs(samples_index))./(abs(samples_index).^(1/4)); %samples of the filter
samples_of_filter(number_of_filter_coffecient+1)=((pi*frequency_doppler_shift)^(1/4))/(gamma(5/4)); %set the value of the filter at the t=0 shoule be pi*fD^(1/4)/gamma(5/4)
%samples_of_filter=samples_of_filter/sqrt(mean(abs(samples_of_filter).^2));
samples_of_filter=samples_of_filter/sqrt((sum(abs(samples_of_filter).^2)));
%to be continued, normalize the filter coffecient

%%
%input complex awgn generation
amplitude_of_input_awgn=1/sqrt(2); %amplitude of input awgn, to be determined
input_awgn=amplitude_of_input_awgn*(randn(number_of_samping,1)+1i*randn(number_of_samping,1)); %input complex awgn generation

%%
%convolution
output_of_filter=conv(input_awgn,samples_of_filter); %output of filter
output_of_filter_discard=output_of_filter(number_of_filter_coffecient+1:number_of_filter_coffecient+number_of_samping); %discard the first and last number_of_filter_coffecient samples

end