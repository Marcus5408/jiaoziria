import { redirect } from "next/navigation";

export default async function Home() {
  // Redirect to the video page
  const videoURL = "https://youtu.be/7ylmK2-1gf0";
  try {
    redirect(videoURL);
  } catch {
    return (
      <main className="flex min-h-screen flex-col items-center justify-center bg-gradient-to-b from-[#2e026d] to-[#15162c] text-white">
        <div className="container flex flex-col items-center justify-center gap-12 px-4 py-16">
          <h1 className="text-5xl font-extrabold tracking-tight sm:text-[5rem]">
            The Jiaoziria Video
          </h1>
          <p>You shouldn&apos;t be here if the redirect worked...</p>
          <p>
            Here&apos;s the video the redirect <i>SHOULD</i> have take you to:
          </p>
          <iframe
            width="1280"
            height="720"
            src={
              // generate the embed URL from the video URL
              videoURL.replace("youtu.be", "youtube.com/embed/")
            }
            title="YouTube video player"
            frameBorder="0"
            allow="accelerometer; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
            allowFullScreen={true}
          ></iframe>
        </div>
      </main>
    );
  }
}
