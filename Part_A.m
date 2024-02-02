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
Hz=1;

%%
%global parameter setting
frequency_carrier = 2*GHz; %carrier frequency
speed=30*KPH; %speed of the transmitter
samping_time_interval=0.1*ms; %sampling time interval
speed_of_light=3e8*MPS; %speed of light
frequency_doppler_shift = speed*frequency_carrier/speed_of_light * Hz; %doppler shift frequency
frequency_sampling = 1/samping_time_interval * Hz; %sampling frequency
number_of_samping=10000;%number of sampling, to be determined

%%
%filter method
number_of_filter_coffecient =1000 ; %number of filter coffecient, to be determined
output_of_filter_discard = filter_method(number_of_samping,samping_time_interval,frequency_doppler_shift,number_of_filter_coffecient);

%%
%spectrum method

%%
%non-global parameter initial
number_of_sample_frequency_method=10000;%to be determined
channel_time_domain=spectrum_method(number_of_sample_frequency_method,samping_time_interval,frequency_doppler_shift);



%%
%










