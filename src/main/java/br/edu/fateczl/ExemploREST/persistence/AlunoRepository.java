package br.edu.fateczl.ExemploREST.persistence;

import org.springframework.data.jpa.repository.JpaRepository;

import br.edu.fateczl.ExemploREST.model.entity.Aluno;

public interface AlunoRepository extends JpaRepository<Aluno, String> {
	
	public Aluno findByCode(String ra);
}
