trait ModuleALike {
  def odd(n: Int): Boolean
}

trait ModuleBLike {
  def even(n: Int): Boolean
}

trait ModuleA extends ModuleALike {
  val b: ModuleBLike
  import b._

  def odd(n: Int): Boolean = if (n == 0) false else even(n - 1)
}

trait ModuleB extends ModuleBLike {
  val a: ModuleALike
  import a._

  def even(n: Int): Boolean = if (n == 0) true else odd(n - 1)
}

object Both extends ModuleA with ModuleB with App {
  val a = this
  val b = this

  println(odd(5))
}
