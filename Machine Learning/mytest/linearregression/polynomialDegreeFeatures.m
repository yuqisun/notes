function X_poly = polynomialDegreeFeatures(X, d)
  [m,n]=size(X);
  degree=polynomialDegree(n, d);
  [rowNum,colNum]=size(degree);

  X_poly=[];
  for i=1:1:rowNum
    X_i_col=prod(X.^degree(i,:), 2);
    X_poly=[X_poly X_i_col];
  end

  X_poly=[X X_poly];
end
