function [m_vec, J_vec, J_cv_vec] = learningCurves(X, y, X_cv, y_cv, theta)
	m_train=length(y);
	m_cv=length(y_cv);
	
	m_min=min(m_train,m_cv);
    m_vec=[];
    J_vec=[];
    J_cv_vec=[];
	for m=0:20:m_min
	    if((m+20)>m_min)
	        break;
	    end
		J_train=costFunction(theta, X(m+1:m+20,:), y(m+1:m+20,:));
		J_cv=costFunction(theta, X_cv(m+1:m+20,:), y_cv(m+1:m+20,:));

		m_vec=[m_vec; m+20];
		J_vec=[J_vec; J_train];
		J_cv_vec=[J_cv_vec; J_cv];

		%plot(m+20, J_train, 'ro');
		%hold on;
		%plot(m, J_cv, 'kx');
		%fprintf('Program paused. Press enter to continue.J_train:[%f], J_cv:[%f]\n', J_train, J_cv);
        %pause;
	end


	plot(m_vec, J_vec, 'r');
	hold on;
	title('Learning Curves');
	xlabel('m (training set size)');
	ylabel('error (cost function J)');
	plot(m_vec, J_cv_vec, 'b');
	legend('training','cross validation');
	hold off;
end
