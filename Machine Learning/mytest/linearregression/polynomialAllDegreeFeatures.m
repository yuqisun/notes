function X_poly = polynomialAllDegreeFeatures(X, d)
  % add lower degree for one item
  % e.g. x=[a b] d=4: add a^2 b^2 a^3 b^3
  [m,n]=size(X);
  degree=polynomialDegree(n, d);
  [rowNum,colNum]=size(degree);

  X_poly=[];
  for i=1:1:rowNum
    X_i_col=prod(X.^degree(i,:), 2);
    X_poly=[X_poly X_i_col];
  end

  X_poly=[X X_poly];

  for i=2:1:d
    for j=1:1:n
        X_poly=[X_poly X(:,j).^i];
    end
  end
end
