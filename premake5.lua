workspace "BaseAPP"
	architecture "x86_64"
	startproject "BaseAPP"

	configurations 
	{
		"Debug", 
		"Release", 
		"Dist"
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

-- Include directories relative to root folder (solution directory)

IncludeDir = {}
IncludeDir["glm"]   	  = "ImGuiMultiplatform/vendor/glm"

LibraryDir = {}
LibraryDir["VulkanSDK"] 	= "%{VULKAN_SDK}/lib"

group "Engine"
	dofile ("ImGuiMultiplatform/EngineExternal.lua")
group ""

group "APP"
project "BaseAPP"
	location "BaseAPP"
	kind "ConsoleApp"
	language "C++"
	cppdialect "C++20"
	staticruntime "on"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files 
	{
		"%{prj.name}/src/**.h", 
		"%{prj.name}/src/**.cpp"
	}

	includedirs 
	{
		"ImGuiMultiplatform/Engine/src",
		"ImGuiMultiplatform/vendor/imgui",
		"%{IncludeDir.glm}"
	}

	links 
	{
		"Engine",
	}

	filter "system:windows"
		systemversion "latest"
	
	filter { "system:linux", "action:gmake2" }

		libdirs
		{
			"%{LibraryDir.VulkanSDK}"
		}

		links 
		{
			"dl",
			"pthread",
			"GL",
			"GLFW",
			"ImGui",
			"SDL2",
			"vulkan"
		}

		systemversion "latest"

	filter "configurations:Debug"
		defines "CF_DEBUG"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		defines "CF_RELEASE"
		runtime "Release"
		optimize "on"

	filter "configurations:Dist"
		defines "CF_DIST"
		runtime "Release"
		optimize "on"
group ""