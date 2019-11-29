function [ model ] = init_ABACOC_model( parameters )

%parameters
model.eps =parameters.eps;%start radius
model.normalize_sample=parameters.normalize_sample;%L1 normalization frames
model.f=parameters.d;%intrinsic dimension
model.add_derivate=parameters.add_derivate;%temporal difference coding
model.ordered_labels=[];
model.num_classes=0;
model.iter=0;


end

