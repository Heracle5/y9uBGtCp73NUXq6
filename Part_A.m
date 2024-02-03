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
storage_xaxis=zeros(9,number_of_histogram);
storage_cdf=zeros(9,number_of_histogram);
for num=1:3
   Rician_filter_method = Rician_kc(output_of_filter_discard,Kc(num));
   Rician_spectrum_method = Rician_kc(channel_time_domain,Kc(num));
   %
    [temp_pdf,temp_xaxis]=hist(abs(Rician_filter_method),number_of_histogram);
    storage_pdf(3*num-2,:)=temp_pdf./sum(temp_pdf);
    storage_xaxis(3*num-2,:)=temp_xaxis;
    [temp_pdf,temp_xaxis]=hist(abs(Rician_spectrum_method),number_of_histogram);
    storage_pdf(3*num-1,:)=temp_pdf./sum(temp_pdf);
   storage_xaxis(3*num-1,:)=temp_xaxis;
   %

xaxis=linspace(temp_xaxis(1),temp_xaxis(end),number_of_histogram);
tmp_s_square=Kc(num)/(Kc(num)+1);
tmp_sigma_square=1/(Kc(num)+1);
Rician_theoretical=abs((xaxis./tmp_sigma_square).*exp(-(xaxis.^2+tmp_s_square)./(2*tmp_sigma_square)).*besselj(0,(sqrt(tmp_s_square).*xaxis)./(tmp_sigma_square)));
storage_pdf(3*num,:)=Rician_theoretical./sum(Rician_theoretical);
storage_xaxis(3*num,:)=xaxis;
end
%%using subplot to plot(Rician_theoretical_pdf Rician_spectrum_method Rician_filter_method with same kc() in the same subplot, so we have just 3 subplots)
figure(2);
subplot(3,1,1);
plot(storage_xaxis(1,:),storage_pdf(1,:),storage_xaxis(2,:),storage_pdf(2,:),storage_xaxis(3,:),storage_pdf(3,:));
xlim([0 2.5]);
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
plot(storage_xaxis(4,:),storage_pdf(4,:),storage_xaxis(5,:),storage_pdf(5,:),storage_xaxis(6,:),storage_pdf(6,:));
xlim([0 2.5]);
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
plot(storage_xaxis(7,:),storage_pdf(7,:),storage_xaxis(8,:),storage_pdf(8,:),storage_xaxis(9,:),storage_pdf(9,:));
xlim([0 2.5]);
xlabel('Amplitude');
ylabel('Probability');
legend('Filter Method','Spectrum Method','Theoretical');
title('Rician Channel PDF (Kc=10)');
grid on;
set(findall(gcf,'-property','FontSize'),'FontSize',12);
set(findall(gcf,'-property','LineWidth'),'LineWidth',2);
set(findall(gcf,'-property','MarkerSize'),'MarkerSize',10);
set(gca,'FontName','Times New Roman');










