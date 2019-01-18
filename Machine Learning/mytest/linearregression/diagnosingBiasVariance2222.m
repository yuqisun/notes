function [d_vec, J_vec, J_cv_vec, d_min, theta_min] = diagnosingBiasVariance(X_train, y_train, X_cv, y_cv, d_num)
	m=length(y_train);
	m_cv=length(y_cv);
	
	X_d=ones(m,1);
	X_cv_d=ones(m_cv,1);

	J_cv_temp=Inf;
	for d=1:d_num
		X_d=[ones(m,1) polynomialAllDegreeFeatures(X_train, d)];
		X_cv_d=[ones(m_cv,1) polynomialAllDegreeFeatures(X_cv, d)];
		%X_d=[X_d X_train.^d];
		%X_cv_d=[X_cv_d X_cv.^d];

		theta=normalEquation(X_d,y_train, 0);
		J=costFunction(theta, X_d, y_train);
		J_cv=costFunction(theta, X_cv_d, y_cv);
		
		if(J_cv<J_cv_temp)
			J_cv_temp=J_cv;
			d_min=d;
			theta_min=theta;
		end;

		d_vec(d)=d;
		J_vec(d)=J;
		J_cv_vec(d)=J_cv;
		
		fprintf('Diagnosing Bias vs. Variance d:%d J:%f J_cv:%f\n', d, J, J_cv);
	end

    subplot(1,2,1);
	plot(d_vec, J_vec, 'r');
	hold on;
	title('Bias vs. Variance');
	xlabel('NO. of polynome degree');
	ylabel('cost function J');
	plot(d_vec, J_cv_vec, 'b');
	legend('training','cross validation');

	subplot(1,2,2);
	lambdas=[0 0.01 0.02 0.04 0.08 0.16 0.32 0.64 1.28 2.56 5.12 10.24];
	X_d=[ones(m,1) polynomialAllDegreeFeatures(X_train, d_min)];
    X_cv_d=[ones(m_cv,1) polynomialAllDegreeFeatures(X_cv, d_min)];
    J_train_l=[];
    J_cv_l=[];
    for lambda=lambdas
        fprintf('lambda:%f\n', lambda);
        theta=normalEquation(X_d,y_train, lambda);
		J=costFunction(theta, X_d, y_train);
		J_cv=costFunction(theta, X_cv_d, y_cv);
		J_train_l=[J_train_l J];
		J_cv_l=[J_cv_l J_cv];
    end

    subplot(1,2,2);
	plot(lambdas, J_train_l, 'r');
    hold on;
	title('Bias vs. Variance');
	xlabel('lambda');
	ylabel('cost function J');
	plot(lambdas, J_cv_l, 'b');
	legend('training','cross validation');
	hold off;
end
