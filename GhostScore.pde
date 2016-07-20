class GhostScore extends GameObject {
  
  int score;
  
  GhostScore(float x, float y, int score) {
   super(x, y); 
   this.score = score;
  }
  
  void render()  {
    text(score, pos.x, pos.y);
  }
  
  void update() {
    
  }
}