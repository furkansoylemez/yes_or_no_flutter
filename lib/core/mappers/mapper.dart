abstract class Mapper<Entity, Model> {
  Model toModel(Entity entity);
  Entity toEntity(Model model);
}
