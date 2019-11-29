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

function [ class, confidence] = ABACOC_predict( X , model )
%X:     multivariate time series cell( dim X t )
%model: classifier model

%how many classes in the model..
num_classes=size(model.ordered_labels,2);

temporal_sample=X{:,:};

if model.normalize_sample==1
    %normalize frames (so values are comparables with derivates)
    temporal_sample=normc(temporal_sample);
end

%add derivate..
if model.add_derivate==1
    temporal_sample =[temporal_sample(:,2:end); diff(temporal_sample,1,2)];
end

%number of frames..
T=size(temporal_sample,2);

class_scores=zeros(1,num_classes);

class_confidence=zeros(1,num_classes);


% for each frames..
for t=1:T
    
    %get the frame..
    sample=temporal_sample(:,t);
    
    %normalize frame..
    if model.normalize_sample==1
        
        %normalize
        norma=norm(sample,2);
        if norma>0
            sample=sample/norma;
        end
        
    end
    
    %search the neareast ball ..
    %[pos_min,dist]=knnsearch(model.kdtreeNS,sample','k',1);
    [pos_min,dist]=knnsearch(model.kdtreeNS,sample');
    
    %calculate kernel distance 
    sigma=model.eps_b(pos_min);
    weight=exp(-( ((dist-sigma)^2)/(2*sigma^2)));
    
    
    %this for the problem that some old balls could have a minor number of
    %class counts, in this case the new classes are all zeros
    class_probs=zeros(1,num_classes);    
    class_probs_for_conf=zeros(1,num_classes);
    
    
    stored_classes_ball=size(model.label_counts{pos_min},2);
    
    %calculate class frequency (add laplace correction + 1/C) (attention to the stored classes in the selected ball (could be lesser than actualy))
    class_probs(1,1:stored_classes_ball)=(model.label_counts{pos_min}+1)./(model.n_x_s(pos_min)+num_classes);
    class_probs_for_conf(1,1:stored_classes_ball)=(model.label_counts{pos_min})./(model.n_x_s(pos_min));
    
    if stored_classes_ball<num_classes
        %put the minimum probabilities to the newer classes
        class_probs(1,(stored_classes_ball+1):end)=1/(model.n_x_s(pos_min)+num_classes);       
    end
        
    
    %take the log of class frequencies
    log_prob= log (class_probs);
    
    %sum logs to the class scores
    class_scores=class_scores + log_prob;
    
    %sum pred confidences
    class_confidence=class_confidence + class_probs_for_conf.*weight;
    
end

%take the class with major score
[val pos]=max(class_scores);

confidence=class_confidence(pos)/T;

%get the correct label
class=model.ordered_labels(pos);
