#include<iostream>
#include<queue>
#include<string>
using namespace std;
struct node{
   int freq;
   char data;
   const node *child0, *child1;
   node(char d, int f = -1){ //assign values in the node
      data = d;
      freq = f;
      child0 = NULL;
      child1 = NULL;
   }
   node(const node *c0, const node *c1){
      data = 0;
      freq = c0->freq + c1->freq;
      child0=c0;
      child1=c1;
   }
   bool operator<( const node &a ) const { //< operator performs to find priority in queue
      return freq >a.freq;
   }
   void traverse(string code = "")const{
      if(child0!=NULL){
         child0->traverse(code+'0'); //add 0 with the code as left child
         child1->traverse(code+'1'); //add 1 with the code as right child
      }else{
         cout << "Data: " << data<< ", Frequency: "<<freq << ", Code: " << code<<endl;
      }
   }
};
void huffmanCoding(string str){
   priority_queue<node> qu;
   int frequency[256];
   for(int i = 0; i<256; i++)
      frequency[i] = 0; //clear all frequency
   for(int i = 0; i<str.size(); i++){
      frequency[int(str[i])]++; //increase frequency
   }
   for(int i = 0; i<256; i++){
      if(frequency[i]){
         qu.push(node(i, frequency[i]));
      }
   }
   while(qu.size() >1){
      node *c0 = new node(qu.top()); //get left child and remove from queue
      qu.pop();
      node *c1 = new node(qu.top()); //get right child and remove from queue
      qu.pop();
      qu.push(node(c0, c1)); //add freq of two child and add again in the queue
   }
   cout << "The Huffman Code: "<<endl;
   qu.top().traverse(); //traverse the tree to get code
}
main(){
   string str = "Loorrreem"; //arbitray string to get frequency
   huffmanCoding(str);
}
