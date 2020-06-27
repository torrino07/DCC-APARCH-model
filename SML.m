function [theta_hat] = SML(v)

 options = optimset('Display','iter',... 
                         'TolFun',1e-12,... 
                         'TolX',1e-12,... 
                         'MaxIter',8000);
      aq=0.1;
      bq=0.1;

      theta_ini = [aq,bq];
      LB = [0,0];   
      UB = [1,1];
      
      [theta_hat, avg_llik_val, exitflag, output, lambda, grad, hessian]=fmincon(@(theta) - llik_fun_DCC(theta,v),theta_ini,[],[],[],[],LB,UB,[],options);

end   

