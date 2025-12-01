--[[
	AUTHOR: FacelessDev (@julimaxx)
--]]

local animation_module = {}

animation_module.Animations = script:WaitForChild('Animations'):GetDescendants()

function animation_module.ReproduceAnimation(humanoid,name,priority,fadeTime)
	local animator = humanoid:WaitForChild('Animator')
	local animation
	
	for _,v in pairs(animation_module.Animations) do
		if v.Name == name then
			animation = v
			break
		end
	end
	
	local animationTrack = animator:LoadAnimation(animation)
	animationTrack.Priority = priority
	animationTrack:Play(fadeTime)
	
	return animationTrack
end

function animation_module.LoadAnimation(humanoid,name,priority)
	
	local character = humanoid.Parent
	local animator = humanoid:WaitForChild('Animator')
	local animation

	for _,v in pairs(animation_module.Animations) do
		if v.Name == name then
			animation = v
			break
		end
	end
	
	game:GetService('RunService').Stepped:Wait()
	
	local animationTrack = animator:LoadAnimation(animation)
	animationTrack.Priority = priority

	return animationTrack
end


function animation_module.SearchAnimation(name)
	for _,v in pairs(animation_module.Animations) do
		if v.Name == name then
			return v
		end
	end
end


function animation_module.StopAnimations(humanoid)
	local playingAnimations = humanoid:WaitForChild('Animator'):GetPlayingAnimationTracks()
	
	for _,track in pairs(playingAnimations) do
		track:Stop()
	end
	
	return true
end


function animation_module.ResumeAnimations(humanoid)
	local playingAnimations = humanoid:WaitForChild('Animator'):GetPlayingAnimationTracks()
	
	for _,track in pairs(playingAnimations) do
		track:Play()
	end

	return true
end


function animation_module.ChangeDefaultAnimation(character,animationToChange,animationName)
	local animate = character:WaitForChild('Animate')
	local animations = animate:GetDescendants()
	local animation = animation_module.SearchAnimation(animationName)
	local playingAnimations = character.Humanoid:WaitForChild('Animator'):GetPlayingAnimationTracks()
	
	for _,v in pairs(animations) do
		if v.Name == animationToChange then
			
			animation_module.StopAnimations(character.Humanoid)

			v.AnimationId = animation.AnimationId	
			
			animation_module.ResumeAnimations(character.Humanoid)
			
			return v
		end
	end
	
end



return animation_module
