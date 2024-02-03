function rician_channel_coff = Rician_kc(channel_time_domain,Kc)
%myFun - Description
%
% Syntax: rician_channel_coff = myFun(input)
%
% Long description
channel_time_domain=channel_time_domain+Kc;
%renormalize the channel
rician_channel_coff=sqrt(length(channel_time_domain))*channel_time_domain./sqrt((sum(abs(channel_time_domain).^2)));
end