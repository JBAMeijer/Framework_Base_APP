#include <EntryPoint.h>
#include <imgui.h>

void Mainloop()
{

}

class AppLayer : public Layer
{
public:
	AppLayer() 
	{
	}

	virtual void OnUIRender() override
	{
		ImGui::ShowDemoWindow();
	}
};

Application* CreateApplication(int argc, char** argv)
{
	Application::Specification spec;
	spec.Name = "Hello World";
	spec.Width = 1280;
	spec.Height = 720;

	Application::ContextAPI Api = Application::ContextAPI::GLFWOpenGL;
	Application* app = Application::Create(Api, spec);

	app->PushLayer<AppLayer>();
	app->SetMenubarCallback([app]()
	{
		if (ImGui::BeginMenu("File"))
		{
			if (ImGui::MenuItem("Exit"))
			{
				app->Close();
			}
			ImGui::EndMenu();
		}
	});

	app->SetMainloopCallback(Mainloop);

	return app;
}