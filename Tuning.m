
load simout

u_optim = simout.data(:);
y_optim = [zeros(size(u_optim,1),1),u_optim];
parameter0 = [780 0 120 42]; % Startwert


optimization_options = optimset('algorithm','levenberg-marquardt',...
    'display','iter','TolX',eps,'TolFun',eps); % options der Optimierung


[parameter,RESNORM,RESIDUAL,EXITFLAG,OUTPUT,LAMBDA,JACOBIAN] = ...
    lsqcurvefit(@sim_model,parameter0,u_optim, y_optim,[0 0 0 0],...
    [10000 10000 10000 10000],optimization_options);

disp(['Die neuen Parameter lauten: (1 entspricht dem Parameter des ' ...
    'Herstellers)'])
parameter