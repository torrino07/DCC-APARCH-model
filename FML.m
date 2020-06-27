function [theta_hat]=FML(x)

 options = optimset('Display','iter',... 
                         'TolFun',1e-12,... 
                         'TolX',1e-12,... 
                         'MaxIter',8000);     

      omega_ini = 0.1;
      alpha_ini = 0.2;
      gamma_ini=0.2;
      delta_ini=0.4;
      beta_ini = 0.2;
      nu_ini=3;
      
      theta_ini = [omega_ini,alpha_ini,gamma_ini,delta_ini,beta_ini,nu_ini];
  
      lb=[0.00001,0,-1,0.001,0,2.01];    
      ub=[100,1,1,100,1,30];  

      [theta_hat,avg_llik_val,exitflag,output,lambda,grad,hessian]=...
          fmincon(@(theta) - llik_fun_APARCH(x,theta),theta_ini,[],[],[],[],lb,ub,[],options);
end