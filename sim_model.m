function F = sim_model(parameter,input_fun)
    
    load simout

    ml = 1;
        
    A = [0, 1, 0, 0;
         -9.81*(1+ml/0.8), 0, 0, .009;
         0, 0, 0, 1;
         12.26*ml, 0, 0, .009];
    B = [0, -30.49, 0, 30.49]';
    
    C = eye(4);
    Cb = diag([1 0 1 0]);
    D = [0,0,0,0]';
    
    Q = diag([parameter(1) parameter(2) parameter(3) parameter(4)]);
    Q_s = diag([1 1 10000 1]);
    Q_r = diag([1 1 10000 1]);
    
    R = 0.00001;

    Kp = zpk(-26, -3429, -26129);
    Ks = zpk(-0.4, -11459, 286474);
    
    
    pole_zustand = [-3, -2.5, -200, -2.6];
    pole_beob = pole_zustand(3) * [3.1, 3.3, 3.5, 3.7];
    
    Kz(ml,:) = acker(A, B, pole_zustand);
    Kb = place(A', Cb', pole_beob)';
    
    
    Kz(ml,:) = lqr(A, B, Q, R);
    Kz_s(ml,:) = lqr(A, B, Q_s, R);
    Kz_r(ml,:) = lqr(A, B, Q_r, R);
     %Kz(ml,:) = acker(A, B, pole_zustand);
     %Kz_s(ml,:) = acker(A, B, pole_zustand);
     %Kz_r(ml,:) = acker(A, B, pole_zustand);
    
    V(ml) =  -1/(C(3,:)*((A-B*Kz(ml,:))\B));
    V_s(ml) =  -1/(C(3,:)*((A-B*Kz_s(ml,:))\B));
    V_r(ml) =  -1/(C(3,:)*((A-B*Kz_r(ml,:))\B));
              
        
        
     
        
        %create time vector       
        
        t = simout.time(:);
        %create the Model
        sysc=ss(A,B,C,D);
        sysc = feedback(sysc, Kz);
        %simulate model by measured input, get the model output
        yout=lsim(sysc,input_fun, t);
        
        %set return value to output of model
        F=[yout(:,1),yout(:,3)];
    end