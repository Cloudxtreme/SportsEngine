% setModel(model_name)
%
% Inputs
%	model_name
%		- A string of the name of the file the model is saved in, without the .mat extension
%
% Sets the global model variable for SkunkWorks to be used in SVM training and testing.
%
function setModel(model_name)

	% Register global variable
	global skunkworks_model

	% Load the model from file
	try
		skunkworks_model = load(sprintf('%s.mat', model_name));
	catch
		fprintf('==========\n');
		fprintf('FILE: CFB/SkunkWorks/Models/setModel.m\n');
		fprintf('ERROR: Could not find file named %s.mat\n', model_name);
		fprintf('==========\n\n');
	end

end
