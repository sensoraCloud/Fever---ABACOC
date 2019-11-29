%   References:
%     - Rocco De Rosa, Nicolò Cesa-Bianchi, Ilaria Gori and Fabio Cuzzolin (2014)
%       Online Action Recognition via Nonparametric Incremental Learning.
%       BMVC 2014.
%    Copyright (C) 2013-2014, Rocco De Rosa
%
%    This program is free software: you can redistribute it and/or modify
%    it under the terms of the GNU General Public License as published by
%    the Free Software Foundation, either version 3 of the License, or
%    (at your option) any later version.
%
%    This program is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.
%
%    You should have received a copy of the GNU General Public License
%    along with this program.  If not, see <http://www.gnu.org/licenses/>.
%
%    Contact the author: rocco.derosa [at] unimi.it

function [ model ] = ABACOC_train( model, X , Y  )
%X:     multivariate time series cell( dim X t )
%model: classifier model (initialized with init_ABACOC_model function)
%Y:     label

%take the video sample
temporal_sample=X{:};

if model.normalize_sample==1
    %normalize frames (so values are comparables with derivates)
    temporal_sample=normc(temporal_sample);
end


%if add derivate..
if model.add_derivate==1
    %add derivate information
    temporal_sample =[temporal_sample(:,2:end); diff(temporal_sample,1,2)];
end


%init
if model.iter==0
       
    %init model with the first sample information
    
    %add the class of the first video..
    model.ordered_labels=Y;
    model.num_classes=1;
    
    %count of learned samples(frames) for each class
    %model.tot_count_class=zeros(1,model.num_classes);
    
    %labels count in each balls
    model.label_counts{1}=ones(1,model.num_classes);
    
    %centers
    if model.add_derivate==1
        %store the first ball, add derivate information
        model.centri=temporal_sample(:,1);
        %double of the dimension..
        model.d=size(temporal_sample(:,1),1)*2;
        %if normalized data..
        if model.normalize_sample==1            
            %normalize L1 norm = 1
            norma=norm(model.centri,2);
            if norma>0
                model.centri=model.centri/norma;
            end
            
        end
    else
        model.centri=temporal_sample(:,1);
        %dimension
        model.d=size(temporal_sample(:,1),1);
        %if normalized data..
        if model.normalize_sample==1            
            %normalize L1 norm = 1
            norma=norm(model.centri,2);
            if norma>0
                model.centri=model.centri/norma;
            end
            
        end
    end
    
    %number of centers
    model.size_centri=1;
    
    %!! we can add the sample to the kd-tree model here
    %update model
    model.kdtreeNS = createns(model.centri','distance','euclidean','NSMethod' ,'kdtree');
       
    %number of samples in each balls
    model.n_x_s(1)=1;
    
    %number of erros in each balls
    model.n_err(1)=0;
    
    %radius of balls
    model.eps_b(1)=model.eps;
    
    %default radius
    model.eps_start(1)=model.eps;    
    
end

%check if the video class is present in the model if not add it
index_current_label=find(ismember(model.ordered_labels,Y)==1);

%if current label is not in the model..
if isempty(index_current_label)    
    %add
    model.ordered_labels(1,end+1)=Y;
    model.num_classes=model.num_classes+1;
%    model.tot_count_class(1,end+1)=0;
    index_current_label=size(model.ordered_labels,2);
end


%number of frames..
T=size(temporal_sample,2);

%count the total number of classes presented to the algorithm
%model.tot_count_class(index_current_label)=model.tot_count_class(index_current_label)+T;

%for each frame of the video..
for t=1:T
    
    %jump the first element already inserted in the initialization
    if model.iter==0
        model.iter=model.iter+1;
        continue;
    end;
    
    %increment iteration
    model.iter=model.iter+1;
    
    %take the t-th frame
    sample=temporal_sample(:,t);
    
    %if normalized data..
    if model.normalize_sample==1
        
        %normalize L1 norm = 1
        norma=norm(sample,2);
        if norma>0
            sample=sample/norma;
        end
        
    end
    
    %calc euclidean distances from balls (we can use kd-tree search here)
    %z=distSqr(sample,model.centri);
    %[min_dist,pos_min]=min(z);
    
    [pos_min,dist]=knnsearch(model.kdtreeNS,sample');
    
    
    %if sample falls into the nearest ball..
    %if sqrt(min_dist) < model.eps_b(pos_min)
    if dist < model.eps_b(pos_min)
        
        %update count points in ball
        model.n_x_s(pos_min)=model.n_x_s(pos_min)+1;
                
        %update class statistics (increment the current class..) attention
        %to old balls with different number of labels
        old_num_classes=size(model.label_counts{pos_min},2);
        if index_current_label<=old_num_classes
            model.label_counts{pos_min}(index_current_label) = model.label_counts{pos_min}(index_current_label)+1;
        else
            new_counts_labels=zeros(1,model.num_classes);
            %save old classes counts
            new_counts_labels(1,1:old_num_classes)=model.label_counts{pos_min};
            %add current label
            new_counts_labels(1,index_current_label)=1;
            %save new counts
            model.label_counts{pos_min} = new_counts_labels;
        end
        
        %check if the current sample belong to the majority class
        [val_p max_pos]=max(model.label_counts{pos_min});
        
        %if current label is different from max class prob shrink
        if not(index_current_label==max_pos)
            
            %increment errors ball
            model.n_err(pos_min)= model.n_err(pos_min)+1;
            
            %shrink the radius
            model.eps_b(pos_min)= model.eps_start(pos_min)*model.n_err(pos_min)^(-1/(2+model.f));
            
        end
        
    else
        
        %add the sample as new ball in the model..
        
        %increment number of balls
        model.size_centri=model.size_centri+1;
        
        %index of the last ball
        pos_insert=model.size_centri;
        
        %add center ball to model
        model.centri(:,end+1)=sample;
        
        %init ball values
        model.n_x_s(pos_insert)=1;
        model.n_err(pos_insert)=0;
        model.label_counts{pos_insert}=zeros(1,model.num_classes);
        model.eps_start(pos_insert)=model.eps;
        model.eps_b(pos_insert)=model.eps;
        
        %update ball class statistics
        model.label_counts{pos_insert}(index_current_label) = model.label_counts{pos_insert}(index_current_label)+1;
        
        %update model (TODO: implement incremental update kd-tree)
        model.kdtreeNS = createns(model.centri','distance','euclidean','NSMethod' ,'kdtree');

    end
    
    
end

%save kd tree for eps-net
%model.kdtreeNS = KDTreeSearcher(model.centri','Distance','euclidean');

%model.kdtreeNS = KDTreeSearcher(model.centri','distance','euclidean');
% 
% 
% function z = distSqr(x,y)
% % function z = distSqr(x,y)
% %
% % Return matrix of all-pairs squared distances between the vectors
% % in the columns of x and y.
% %
% % INPUTS
% % 	x 	dxn matrix of vectors
% % 	y 	dxm matrix of vectors
% %
% % OUTPUTS
% % 	z 	nxm matrix of squared distances
% %
% % This routine is faster when m<n than when m>n.
% %
% % David Martin <dmartin@eecs.berkeley.edu>
% % March 2003
% 
% % Based on dist2.m code,
% % Copyright (c) Christopher M Bishop, Ian T Nabney (1996, 1997)
% 
% if size(x,1)~=size(y,1),
%     error('size(x,1)~=size(y,1)');
% end
% 
% [d,n] = size(x);
% [d,m] = size(y);
% 
% % z = repmat(sum(x.^2)',1,m) ...
% %     + repmat(sum(y.^2),n,1) ...
% %     - 2*x'*y;
% 
% z = x'*y;
% x2 = sum(x.^2)';
% y2 = sum(y.^2,1);
% 
% for i = 1:m,
%     z(:,i) = x2 + y2(i) - 2*z(:,i);
% end



