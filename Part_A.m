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
[channel_time_domain,theoretical_psd]=spectrum_method(number_of_sample_frequency_method,samping_time_interval,frequency_doppler_shift);



%%
%figure compared (filter method VS spectrum method VS  theoretical)
figure(1);
a=pwelch(output_of_filter_discard,[],[],10000,frequency_sampling,'centered','power','r');
b=pwelch(channel_time_domain,[],[],10000,frequency_sampling,'centered','power','r');
plot(-frequency_sampling/2:frequency_sampling/number_of_samping:frequency_sampling/2-frequency_sampling/number_of_samping,pow2db([a b]));
hold on;
plot(-frequency_sampling/2:frequency_sampling/number_of_samping:frequency_sampling/2-frequency_sampling/number_of_samping,pow2db(theoretical_psd));
xlim([-150 150]);
xlabel('Frequency (Hz)');
ylabel('Power/Frequency (dB/Hz)');
legend('Filter Method','Spectrum Method','Theoretical');
title('Comparison of Filter Method and Spectrum Method');
grid on;
set(findall(gcf,'-property','FontSize'),'FontSize',12);
set(findall(gcf,'-property','LineWidth'),'LineWidth',2);
set(findall(gcf,'-property','MarkerSize'),'MarkerSize',10);
set(gca,'FontName','Times New Roman');
hold off;

%%
%figure compared rician channel(filter method VS spectrum method vs theoretical) pdf version (kc=0,1,10)
%%
%case kc=0;
Kc=[0,1,10];
number_of_histogram=100;
storage_pdf=zeros(9,number_of_histogram);
%storage_xaxis=zeros(9,number_of_histogram);
xaxis=linspace(0,30,number_of_histogram);
storage_cdf=zeros(9,number_of_histogram);
for num=1:3
   Rician_filter_method = Rician_kc(output_of_filter_discard,Kc(num));
   Rician_spectrum_method = Rician_kc(channel_time_domain,Kc(num));
   %
%     [temp_pdf,temp_xaxis]=hist(abs(Rician_filter_method),number_of_histogram);
    temp_pdf=fitdist(abs(Rician_filter_method),'Rician');
    temp_pdf=pdf(temp_pdf,xaxis);
    storage_pdf(3*num-2,:)=temp_pdf;
    %storage_xaxis(num,:)=temp_xaxis;
    temp_pdf=fitdist(abs(Rician_spectrum_method),'Rician');
    temp_pdf=pdf(temp_pdf,xaxis);
    %[temp_pdf,temp_xaxis]=hist(abs(Rician_spectrum_method),number_of_histogram);
    storage_pdf(3*num-1,:)=temp_pdf;
    %storage_xaxis(num+1,:)=temp_xaxis;
    Rician_theoretical = makedist('Rician','s',Kc(num),'sigma',1);
    Rician_theoretical_pdf=pdf(Rician_theoretical,xaxis);
    storage_pdf(3*num,:)=Rician_theoretical_pdf;
    %storage_xaxis(num+2,:)=temp_xaxis;
end
%%using subplot to plot(Rician_theoretical_pdf Rician_spectrum_method Rician_filter_method with same kc() in the same subplot, so we have just 3 subplots)
figure(2);
subplot(3,1,1);
plot(xaxis,storage_pdf(1,:),xaxis,storage_pdf(2,:),xaxis,storage_pdf(3,:));
xlabel('Amplitude');
ylabel('Probability');
legend('Filter Method','Spectrum Method','Theoretical');
title('Rician Channel PDF (Kc=0)');
grid on;
set(findall(gcf,'-property','FontSize'),'FontSize',12);
set(findall(gcf,'-property','LineWidth'),'LineWidth',2);
set(findall(gcf,'-property','MarkerSize'),'MarkerSize',10);
set(gca,'FontName','Times New Roman');
subplot(3,1,2);
plot(xaxis,storage_pdf(4,:),xaxis,storage_pdf(5,:),xaxis,storage_pdf(6,:));
xlabel('Amplitude');
ylabel('Probability');
legend('Filter Method','Spectrum Method','Theoretical');
title('Rician Channel PDF (Kc=1)');
grid on;
set(findall(gcf,'-property','FontSize'),'FontSize',12);
set(findall(gcf,'-property','LineWidth'),'LineWidth',2);
set(findall(gcf,'-property','MarkerSize'),'MarkerSize',10);
set(gca,'FontName','Times New Roman');
subplot(3,1,3);
plot(xaxis,storage_pdf(7,:),xaxis,storage_pdf(8,:),xaxis,storage_pdf(9,:));
xlabel('Amplitude');
ylabel('Probability');
legend('Filter Method','Spectrum Method','Theoretical');
title('Rician Channel PDF (Kc=10)');
grid on;
set(findall(gcf,'-property','FontSize'),'FontSize',12);
set(findall(gcf,'-property','LineWidth'),'LineWidth',2);
set(findall(gcf,'-property','MarkerSize'),'MarkerSize',10);
set(gca,'FontName','Times New Roman');










