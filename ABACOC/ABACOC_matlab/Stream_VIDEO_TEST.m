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


close all

%clear all
addpath(genpath('dataset'));

datasetName='jvowels_TestTrain';

%parameters
parameters.eps=.2;%start radius
parameters.normalize_sample=1;%L1 normalization frames
parameters.d=3;%intrinsic dimension
parameters.add_derivate=1;%temporal difference coding


%import videos
dataset=importdata(fullfile('dataset',[datasetName,'.mat']));

%TRAIN

%init classifier model (the learn model is not optimatized. For incremental learning We need an incremental nearest neighbour search (e.g. incremental kd-tree))
class_model=init_ABACOC_model(parameters);

num_class=size(dataset.train,1);
num_train_ist=size(dataset.train,2);


for cc=1:num_class
    for n=1:num_train_ist
        
        if not(isempty(dataset.train(cc,n)))
            
            video=dataset.train(cc,n);
            
            %incremental learning step (code not optimized for incremental learning)
            [ class_model ] = ABACOC_train( class_model, video , cc  );
            
            
        end
        
    end
end



%TEST

num_test_ist=size(dataset.test,2);
count_videos=0;
count_correct_predictios=0;

confidence_pos=[];
confidence_neg=[];

for cc=1:num_class
    for n=1:num_test_ist
        
        if not(isempty(dataset.test{cc,n}))
            
            video=dataset.test(cc,n);
                        
            [pred confidence]=ABACOC_predict(video,class_model);
            
            if pred==cc
                count_correct_predictios=count_correct_predictios+1;
                if isempty(confidence_pos)
                    confidence_pos=confidence;
                else
                    confidence_pos(end+1,1)=confidence;
                end
            else
                if isempty(confidence_neg)
                    confidence_neg=confidence;
                else
                    confidence_neg(end+1,1)=confidence;
                end
            end
            
            
            count_videos=count_videos+1;
            
        end
        
    end
end

accuracy=count_correct_predictios/count_videos
%mean(confidence_pos)
%mean(confidence_neg)
