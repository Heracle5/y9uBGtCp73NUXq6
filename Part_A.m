%%
%Initialization
clc;
clear all;
close all;

%%
%Unit predefined
GHz=1e9;
MPS=1;
KPH=1/3.6;
ms=1e-3;

%%
%global parameter setting
frequency_carrier = 2*GHz; %carrier frequency
speed=30*KPH; %speed of the transmitter
samping_time_interval=0.1*ms; %sampling time interval
speed_of_light=3e8*MPS; %speed of light

%%
%filter coffecient calculation
frequency_doppler_shift = speed*frequency_carrier/speed_of_light; %doppler shift frequency
frequency_sampling = 1/samping_time_interval; %sampling frequency
number_of_samping=;%number of sampling, to be determined
number_of_filter_coffecient = ; %number of filter coffecient, to be determined
samples_index=(-number_of_filter_coffecient:1:number_of_filter_coffecient)*samping_time_interval; %index of samples
samples_of_filter=besselj(1/4,2*pi*frequency_doppler_shift*abs(samples_index))./(abs(samples_index).^(1/4)); %samples of the filter
samples_of_filter(number_of_filter_coffecient+1)=((pi*frequency_doppler_shift)^(1/4))/(gammar(5/4)); %set the value of the filter at the t=0 shoule be pi*fD^(1/4)/gamma(5/4)
%to be continued, normalize the filter coffecient

%%
%input complex awgn generation
amplitude_of_input_awgn=; %amplitude of input awgn, to be determined
input_awgn=amplitude_of_input_awgn*(randn(number_of_samping,1)+1i*randn(number_of_samping,1)); %input complex awgn generation

%%
%convolution
output_of_filter=conv(input_awgn,samples_of_filter); %output of filter
output_of_filter_discard=output_of_filter(number_of_filter_coffecient+1:number_of_filter_coffecient+number_of_samping); %discard the first and last number_of_filter_coffecient samples



